# encoding: utf-8
module Enqueuable
  def enqueue(*args)
    job = new(*args)
    Delayed::Job.enqueue(job)
  end
end
