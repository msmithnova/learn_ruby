def measure(n=1)
  run_times = []
  n.times do
    start = Time.now
    yield
    run_times << Time.now - start
  end
  run_times.inject(:+).to_f / run_times.length
end