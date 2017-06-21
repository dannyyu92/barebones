# To queue with resque-scheduler: TestJob.wait(5.seconds).perform_later

class TestJob < ApplicationJob
  queue_as :default
 
  def perform
    puts "ActiveJob is working."
  end
end