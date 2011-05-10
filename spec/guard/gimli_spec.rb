require 'spec_helper'

describe Guard::Gimli do
  subject { Guard::Gimli.new }

  describe "#initialize" do
    describe ":outputdir" do
      it "is nil by default" do
        subject = Guard::Gimli.new([])
        subject.options[:outputdir].should be_nil
      end

      it "can be set " do
        subject = Guard::Gimli.new([], { :outputdir => 'build' })
        subject.options[:outputdir].should == 'build'
      end
    end
    describe ":stylesheet" do
      it "is nil by default" do
        subject = Guard::Gimli.new([])
        subject.options[:stylesheet].should be_nil
      end

      it "can be set " do
        subject = Guard::Gimli.new([], { :stylesheet => 'style.css' })
        subject.options[:stylesheet].should == 'style.css'
      end
    end
  end

  describe "#start" do
    it "creates refresher with default options" do
      subject = Guard::Gimli.new([])
      mock(Guard::Gimli::Converter).new(:outputdir => nil, :stylesheet => nil)
      subject.start
    end

    it "creates reactor with outputdir" do
      subject = Guard::Gimli.new([], { :outputdir => 'build' })
      mock(Guard::Gimli::Converter).new(:outputdir => 'build', :stylesheet => nil)
      subject.start
    end

    it "creates reactor with stylesheet" do
      subject = Guard::Gimli.new([], { :stylesheet => 'style.css' })
      mock(Guard::Gimli::Converter).new(:stylesheet => 'style.css', :outputdir => nil)
      subject.start
    end

    it "creates reactor with outputdir and stylesheet" do
      subject = Guard::Gimli.new([], { :outputdir => 'build', :stylesheet => 'style.css' })
      mock(Guard::Gimli::Converter).new(:outputdir => 'build', :stylesheet => 'style.css')
      subject.start
    end
  end

  describe "#run_on_change" do
    it "converts pdfs" do
      converter = Guard::Gimli::Converter.new({})
      mock(subject).converter { converter }
      mock(converter).reload(['foo'])
      subject.run_on_change(['foo'])
    end
  end
end

