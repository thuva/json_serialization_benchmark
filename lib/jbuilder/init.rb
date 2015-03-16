# Based on render_anywhere: https://github.com/yappbox/render_anywhere/blob/master/lib/render_anywhere.rb
require 'abstract_controller'
require 'action_view'

require 'ostruct'

class RenderingController < ActionController::Metal
  # Include all the concerns we need to make this work
  include AbstractController::Logger
  include AbstractController::Rendering
  include ActionView::Layouts if defined?(ActionView::Layouts) # Rails 4.1.x
  include AbstractController::Layouts if defined?(AbstractController::Layouts) # Rails 3.2.x, 4.0.x
  include AbstractController::Helpers
  include AbstractController::Translation
  include AbstractController::AssetPaths
  include ActionController::Caching

  # Define additional helpers, this one is for csrf_meta_tag
  helper_method :protect_against_forgery?

  # override the layout in your subclass if needed.
  layout 'application'

  # configure the different paths correctly
  def initialize(*args)
    super()

    lookup_context.view_paths = File.expand_path(File.dirname(__FILE__) + '/views') # TODO it'd be clearer to pass this in
    config.javascripts_dir = ''
    config.stylesheets_dir = ''
    config.assets_dir = ''
    config.cache_store = ActionController::Base.cache_store

    # same asset host as the controllers
    self.asset_host = ''
  end

  # we are not in a browser, no need for this
  def protect_against_forgery?
    false
  end

  # so that your flash calls still work
  def flash
    {}
  end

  # and nil request to differentiate between live and offline
  def request
    OpenStruct.new
  end

  # and params will be accessible
  def params
    {}
  end

  # so that your cookies calls still work
  def cookies
    {}
  end

end

require 'jbuilder/jbuilder_template'
ActionView::Template.register_template_handler :jbuilder, JbuilderHandler

class Jbuilder
  def self.render(*args)
    @rendering_controller ||= ::RenderingController.new

    @rendering_controller.render_to_string(*args)
  end
end