require "employee"

class Startup

    attr_reader :name, :funding, :salaries, :employees

    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        salaries.include?(title) ? true : false
    end

    def >(startup)
        @funding > startup.funding ? true : false
    end

    def hire(name, title)
        if !self.valid_title?(title)
            raise "Title is not valid"
        else
            @employees.push(Employee.new(name, title))
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        if @funding >= @salaries[employee.title]
            employee.pay(@salaries[employee.title])
            @funding -= @salaries[employee.title]
        else
            raise "Not Enough Funding"
        end
    end

    def payday
        @employees.each do |employee|
            self.pay_employee(employee)
        end
    end

    def average_salary
        @employees.inject(0) { |acc, el| acc + @salaries[el.title] } / @employees.length
    end

    def close
        @employees = []
        @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        @salaries.merge!(startup.salaries) {|key, ov, nv| ov}
        @employees.concat(startup.employees)
        startup.close
    end

end
