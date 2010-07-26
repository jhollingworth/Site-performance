class AbOutputParser

	attr_accessor :mean_time_per_request, :mean_concurrent_time_per_request

	def initialize(output)
		output.split(/\n/).each do |line|
			if (line =~ /Time per request\:(.*)\[ms\].*mean\)/) != nil
				@mean_time_per_request = $1.strip
			end
			if (line =~ /Time per request\:(.*)\[ms\].*mean, across all concurrent requests/) != nil
				@mean_concurrent_time_per_request = $1.strip
			end
				
		end
	end
	
	
end