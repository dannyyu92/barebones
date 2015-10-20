# To queue with resque-scheduler: TestJob.wait(5.second).perform_later

class TestJob < ActiveJob::Base
  queue_as :default
 
  def perform
    puts "Resque is working."
  end
end