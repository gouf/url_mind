# frozen_string_literal: true

require 'job_grouping' # lib/job_grouping.rb

describe JobGrouping do
  context 'when 100 ids passed' do
    let(:ids) { (1..10).to_a }

    subject { JobGrouping.new(ids, group_delay_seconds: 1, process_group_chunk: 5).separate_to_groups.to_a }

    it 'class is Enumerator::Lazy' do
      klass =
        JobGrouping.new(ids, group_delay_seconds: 1, process_group_chunk: 5)
                   .separate_to_groups
                   .class

      expect(klass).to eq Enumerator::Lazy
    end

    it 'returns 5 groups of array' do
      expect(subject.size).to eq 5
    end

    it 'ids separated as [1, 2], [3, 4], [5, 6], [7, 8], [9, 10]' do
      grouped_ids = subject.map(&:last)

      expect(grouped_ids).to eq [[1, 2], [3, 4], [5, 6], [7, 8], [9, 10]]
    end

    it 'last of delay group is 5 sec.' do
      last_delay_group_sec = subject.last.first

      expect(last_delay_group_sec).to eq 5
    end
  end
end
