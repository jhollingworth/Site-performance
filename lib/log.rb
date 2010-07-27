class Log

	def self.message(message)
        puts teamcity? ? "##teamcity[progressMessage '#{tc_sanitize(message)}']" : message
	end
	
	def self.stat(key, value) 
		puts teamcity? ? "##teamcity[buildStatisticValue key='#{key}' value='#{value}']" : "#{key}: #{value}"
	end
	
	private

	def self.tc_sanitize(message)
		message.gsub(/\n/,'|n').gsub(/'/, '|').gsub(/]/,'|\]')
    end

    def self.teamcity?()
      ENV['TEAMCITY_VERSION'] != nil
    end
end