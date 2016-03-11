# Sinatra Group Items

This is a [Sinatra][1] extension.

### Installation
In order to install this gem, you just need to install the gem from your command line like this:
  
    $sudo gem install sinatra-group-items

### Usage

See examples directory.
If you follow the __Classic__ approach, then you just need to require this extension in the *app.rb* file.

    require 'sinatra'
    require 'sinatra/group_items'
    
Then you should require your *app.rb* file inside the *config.ru* file in order to make your application runnable.

    require 'app'
    disable :run
    run Sinatra::Application

You can test your application by executing the following command on your command line.

    $app/ruby app.rb
    
If you follow the __Modular__ approach, then you just need to declare your application as a class
that inherit from the *Sinatra::Base* class and then register the extension inside it in the *app.rb* file.

    require 'sinatra/base'
    require 'sinatra/pages'
    
    class App < Sinatra::Base
      register Sinatra::GroupItems
    end

Then you should require your *app.rb* inside the *config.ru* file and associate your application class to a certain route.

    require 'app'
    map '/' do
      run Sinatra::App
    end

You can try your modular application by executing the following command in your command line.

    $app/rackup config.ru
  
In order to verify if you application is working, open your web browser with the address
that will appear after the execution described above.


### Contributions
Everybody is welcome to contribute to this project by commenting the source code,
suggesting modifications or new ideas, reporting bugs, writing some documentation and, of course,
you're also welcome to contribute with patches as well!

In case you would like to contribute on this library, here's the list of extra dependencies you would need:

* [rspec][5]
* [rack-test][6]

### Rubies
This extension have been tested on [MRI][8] 1.9.2.

### License
This extension is licensed under the [MIT License][9].

[1]: http://www.sinatrarb.com/
[4]: http://rack.rubyforge.org/
[5]: http://rspec.info/
[8]: http://www.ruby-lang.org/en/
[9]: http://creativecommons.org/licenses/MIT/
