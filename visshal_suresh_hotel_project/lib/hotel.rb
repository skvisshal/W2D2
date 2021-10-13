require_relative "room"

class Hotel
  
    attr_reader :rooms

    def initialize(name, hash)
        @name = name
        @rooms = {}
        hash.each do |key, value|
            @rooms[key] = Room.new(value)
        end
    end

    def name
        words = @name.split
        words.map! {|word| word.capitalize}
        words.join(" ")
    end

    def room_exists?(name)
        @rooms.include?(name) ? true : false
    end

    def check_in(person, room)
        if !room_exists?(room)
            puts "sorry, room does not exist"
        else
           puts @rooms[room].add_occupant(person) ? "check in successful" : "sorry, room is full"
        end
    end

    def has_vacancy?
        @rooms.any? {|key, value| !value.full?} ? true : false
    end

    def list_rooms
        @rooms.each do |key , value|
            puts key + value.available_space.to_s
        end
    end
end
