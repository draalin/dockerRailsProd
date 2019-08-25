# class HardWorker
#   include Sidekiq::Worker

#   def perform(*args)
#     # Do something
#   end
# end

class HardWorker
  include Sidekiq::Worker

  # To use OurWorker manually, just call the instance method:
  #
  #     OurWorker.new.perform("super_hard")
  #
  # The argument can be one of "super_hard", "hard", or anything else (which will
  # presume easy work)
  #
  # To start the sidekiq worker:
  #
  #     $ bundle exec sidekiq -r ./worker.rb
  #
  # To create a new job for it to perform in the background:
  #
  #     $ bundle exec irb -r ./worker.rb
  #     > OurWorker.perform_async "super_hard"

  # We'll define the perform method on our worker.  This is the entire
  # API you need to concern yourself with when writing Workers in Sidekiq.

  # Our method will take a single argument - a string representing the
  # complexity of the job.
  def perform(complexity)
    case complexity
    when "super_hard"
      # We'll just put sleep statements in to simulate different amounts of work.
      sleep 20
      puts "Really took quite a bit of effort"
    when "hard"
      sleep 10
      puts "That was a bit of work"
    else
      sleep 1
      puts "That wasn't a lot of effort"
    end
  end
end