
# class Movement
#     def move
#         puts "can move"
#     end
# end

# class Automobile

# end

# # composition: creating an instance of another class within current class
# class Car < Automobile
#     def initialize
#         @movement = Movement.new
#         @movement.move
#     end
# end

# @car1 = Car.new

# Drinks availble
# Bartender: get the drink and server it to the customer
# customer reading amenu
# ordering drinks

# Model : deals with data : drink is the data
# initialize the drinks available
# get a drink
# get available drinks


class BarModel
    def initialize
        @drinks = {
            beer: 10,
            martini: 10,
            coke: 10
        }
    end

    def get_drink(drink_name)
        # check if drink requested is avaialble
        if(@drinks[drink_name] && (@drinks[drink_name] - 1 >= 0))
            # decrement the quantity of drink given out
            @drinks[drink_name] -= 1
            return drink_name
        end
        # if the drink is not available return nil, so we can send a valid msg to the user later from view
        return nil
    end

    def get_available_drinks
        @drinks_available = []
        # code here
        @drinks.each do |drink_name, count|
            if count > 0 
                 @drinks_available.push(drink_name)
            end
        end
        return @drinks_available
    end

end

# view: customer interaction
# greeting a customer
# read a menu
# making a selection
# wrong msg
# place an order

class BarView
    def greeting
        puts "welcome to the Coder Bar"
    end

    def selection
        puts "select one of the option below
        1. Read the menu
        2. place your order "
        user_input = gets.chomp.to_i
    end

    def read_menu(items)
        items.each do |item|
            puts item.capitalize
        end
    end

    def place_order
        puts "what would you like to drink"
        order = gets.chomp.downcase
        return order
    end
    
    def good_bye
        puts "Thanks see you later"
    end

    def wrong_msg
        puts "wrong input try again"
    end
end

class BarController 
    def initialize
        # create the model and view instance to access the correcponding methods
        @model = BarModel.new
        @view = BarView.new
    end

    def greet_and_get_selection
        @view.greeting
        user_input = @view.selection
        return user_input
    end

    # controller method is the point of entry to the app
    def run
        while true
            selection = greet_and_get_selection
            if((selection!= 1) && (selection !=2))
                @view.wrong_msg
            
            elsif(selection == 1)
                # read the menu
                @view.read_menu(@model.get_available_drinks)
            else
                # take order
                drink_ordered = @view.place_order
                drink_received = @model.get_drink(drink_ordered.to_sym)
                # error handling to ensure the drink is received
                drink_received ? drink_received : @view.wrong_msg
                return drink_received
            end
        end
    end
end

@controller = BarController.new
drink = @controller.run
puts drink