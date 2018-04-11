# Separate jobs into groups for delay processing of Active Job
class JobGrouping
  def initialize(ids, group_delay_seconds: 30, process_group_chunk: 30)
    @delay_seconds = group_delay_seconds
    @process_group_chunk = process_group_chunk
    @ids = ids
  end

  # compose delay seconds group and processing ids group
  def separate_to_groups
    delay_group.zip(process_group)
    # => [
    #   [30, [1, 2, 3, ...]],
    #   [60, [10, 11, 12, ...]],
    #   ...,
    # ]
  end

  private

  # split record ids into group by chunk size
  def process_group
    slice_size = 0.step(@ids.size, @process_group_chunk).size

    @ids.each_slice(slice_size).lazy
    # => [[1, 2, 3, ...], [10, 11, 12, ...], ...]
  end

  def delay_group
    Array.new(process_group.size, nil).inject([]) { |ret, _| ret << ret.last.to_i + @delay_seconds }.lazy
    # => [30, 60, 90, 120, ...]
  end
end
