class Log 
	def self.message(message)
		puts "##teamcity[progressMessage '#{tc_sanitize(message)}']"
	end
	
	def self.stat(key, value) 
		puts "##teamcity[buildStatisticValue key='#{key}' value='#{value}']"
	end
	
	private

	def self.tc_sanitize(message)
		message.gsub(/\n/,'|n').gsub(/'/, '|').gsub(/]/,'|\]')
	end
end