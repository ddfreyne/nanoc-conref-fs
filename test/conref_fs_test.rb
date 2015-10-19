require 'test_helper'

class DatafilesTest < MiniTest::Test

  def test_it_renders_conrefs_in_frontmatter
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('frontmatter', 'title')
      test_file = read_test_file('frontmatter', 'title')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_conrefs_in_frontmatter_at_different_path
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('frontmatter', 'different')
      test_file = read_test_file('frontmatter', 'different')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_conrefs_in_frontmatter_with_audience
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('frontmatter', 'audience')
      test_file = read_test_file('frontmatter', 'audience')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_nested_conrefs
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('datafiles', 'deep')
      test_file = read_test_file('datafiles', 'deep')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_nested_conrefs
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('datafiles', 'deep')
      test_file = read_test_file('datafiles', 'deep')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_single_parents
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('parents', 'single_parent')
      test_file = read_test_file('parents', 'single_parent')
      assert_equal output_file, test_file
    end
  end

  def test_it_renders_two_parents
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('parents', 'two_parents')
      test_file = read_test_file('parents', 'two_parents')
      assert_equal output_file, test_file
    end
  end

  def test_missing_cateogory_title_does_not_blow_up_parents
    with_site(name: FIXTURES_DIR) do |site|

      site = Nanoc::Int::SiteLoader.new.new_from_cwd
      site.compile

      output_file = read_output_file('parents', 'missing_title')
      test_file = read_test_file('parents', 'missing_title')
      assert_equal output_file, test_file
    end
  end
end
