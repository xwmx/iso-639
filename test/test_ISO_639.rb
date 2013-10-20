# encoding: UTF-8
require 'helper'

class TestISO639 < Test::Unit::TestCase
  
  should "have full code list in ISO_639_2" do
    assert_equal 485, ISO_639::ISO_639_2.length
  end
  
  should "have shorter code list in ISO_639_1" do
    assert_equal 184, ISO_639::ISO_639_1.length
  end
  
  should "return entry for alpha-2 code" do
    assert_equal ["eng", "", "en", "English", "anglais"], ISO_639.find_by_code("en")
    assert_equal ["eng", "", "en", "English", "anglais"], ISO_639.find("en")
  end
  
  should "find by english name" do
    assert_equal ["eng", "", "en", "English", "anglais"], ISO_639.find_by_english_name("English")
  end
  
  should "find by french name" do
    assert_equal ["eng", "", "en", "English", "anglais"], ISO_639.find_by_french_name("anglais")
  end
  
  %w[
    alpha3_bibliographic
    alpha3
    alpha3_terminologic
    alpha2
    english_name
    french_name
  ].each_with_index do |m, i|
    should "respond to and return #{m}" do
      @entry = ISO_639.find("en")
      assert @entry.respond_to?(m)
      assert_equal ["eng", "eng", "", "en", "English", "anglais"][i], @entry.send(m)
    end
  end

  should "return single record array by searching a unique code" do
    assert_equal(
      [["spa", "", "es", "Spanish; Castilian", "espagnol; castillan"]],
      ISO_639.search("es")
    )
  end

  should "return single record array by searching a unique term" do
    assert_equal(
      [["spa", "", "es", "Spanish; Castilian", "espagnol; castillan"]],
      ISO_639.search("spanish")
    )
  end

  should "return multiple record array by searching a common term" do
    assert_equal(
      [
        ["egy", "", "", "Egyptian (Ancient)", "égyptien"],
        ["grc", "", "", "Greek, Ancient (to 1453)", "grec ancien (jusqu'à 1453)"]
      ],
      ISO_639.search("ancient")
    )
  end

  should "return empty array when searching a non-existent term" do
    assert_equal(
      [], ISO_639.search("bad term")
    )
  end


  
end
