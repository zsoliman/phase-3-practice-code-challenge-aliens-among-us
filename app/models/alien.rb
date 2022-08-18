class Alien < ActiveRecord::Base
    has_many :visitations
    has_many :earthlings, through: :visitations


    def visit(earthling)
        Visitation.create(date: Date.today, alien_id: self.id, earthling_id: earthling)
    end

    def total_light_years_traveled
        self.light_years_to_home_planet * self.visitations.length * 2
    end

    def self.most_frequent_visitor
        self.all.max_by { |alien| alien.visitations.size }
    end

    def self.average_light_years_to_home_planet
        self.all.sum(:light_years_to_home_planet) / self.all.length.to_f
    end

end
