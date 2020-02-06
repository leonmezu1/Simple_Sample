class ApplicationController < ActionController::Base
	def hello
		render html: 'hello_world'
	end
end
