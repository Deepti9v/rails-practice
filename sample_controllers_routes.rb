class UsersController < ApplicationController
    $globalvar = 0
    def index
        render text:"hello from the root"
    end
    def hello
        render text:"hello"
    end
    def say_hello
        render text:"saying hello"
    end
    def say_hello_touser
        #hint: Either Redirect or render,both is not possible
        if (params[:name] == "Deepti")
            redirect_to '/say/hello'
        elsif ( params[:name] != nil || params[:name] != "")
            render text: "Saying Hello #{params[:name]}!"
        end
    end
    def times
        $globalvar = $globalvar+1;
        session[:var] =   (session[:var]+1) || 0
        render text:"Hello you have navigated to this page for #{$session[:var]} times"
    end
    def restart
        reset_session
        render text:"The session is restarted"
    end
end

Rails.application.routes.draw do
    get 'hello' => 'users#hello'
    get 'say/hello' => 'users#say_hello'
    get 'say/hello/:name' => 'users#say_hello_touser'
    get '/' => 'users#index'
    get 'times' => 'users#times'
    get 'times/restart' => 'users#restart'
end
