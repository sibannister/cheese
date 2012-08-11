require 'showing'
require 'spec_helper'

describe Showing do
  let(:showing) { build :showing }

  it 'should convert a showing to a json string' do
    showing = Showing.new 'The Godfather', 
                          Time.new(2010, 4, 11, 23, 45, 0),
                          Time.new(2010, 4, 12, 1, 15, 0),
                          'ITV',
                          'imageurl',
                          9.2

    showing.to_json.should == '{"name":"The Godfather","rating":9.2,"channel":"ITV","start":"2010-04-11 23:45","end":"2010-04-12 01:15","image":"imageurl"}'
  end

  it 'should represent nil ratings as zero in the json string' do
    showing = build :showing, :rating => nil
    showing.to_json.should include '"rating":0'
  end

  it 'should give a better match score if all the words are included' do
    Showing.title_match_score('The Drum', 'The Drum (1938)').should > 
                          Showing.title_match_score('The Drum', 'Die Blechtrommel (1979)')
  end

  context 'equality' do
    it 'should recognise two identical showings as equal' do
      identical_showing = build :showing
      showing.should == identical_showing
    end

    it 'should recognise showings on different channels as unequal' do
      different_showing = build :showing, :channel => 'different'
      showing.should_not == different_showing
    end

    it 'should recognise two differently rated showings as unequal' do
      different_showing = build :showing, :rating => 3.5
      showing.should_not == different_showing
    end

    it 'should recognise two differently named showings as unequal' do
      different_showing = build :showing, :name => 'different'
      showing.should_not == different_showing
    end

    it 'should recognise showings with different end times unequal' do
      different_showing = build :showing, :end_date => Time.now
      showing.should_not == different_showing
    end

    it 'should recognise showings with different start times unequal' do
      different_showing = build :showing, :start_date => Time.now
      showing.should_not == different_showing
    end

    it 'should recognise showings with different images as unequal' do
      different_showing = build :showing, :image_url => 'different'
      showing.should_not == different_showing
    end
  end
end
