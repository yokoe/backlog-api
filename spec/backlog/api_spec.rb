# coding: utf-8

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'spec_helper'))

describe Backlog::API do
  describe "プロジェクトAPI" do
    context "プロジェクトの一覧を取得する" do
      let(:projects) {
        [{"id" => 100,
          "name" => "test",
          "key" => "TEST",
          "url" => "http://hoge.backlog.jp/TEST",
          "archived" => false}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { projects }
      end

      it "プロジェクトのリストを取得できる" do
        @client.get_projects.class.should == Array
      end
    end

    context "プロジェクトを取得する" do
      let(:project) {
        {"id" => 100,
          "name" => "test",
          "key" => "TEST",
          "url" => "http://hoge.backlog.jp/TEST",
          "archived" => false}
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { project }
      end

      it "project_idを指定してプロジェクトを取得できる" do
        @client.get_project(100).class.should == Backlog::Object::Project
      end

      it "keyを指定してプロジェクトを取得できる" do
        @client.get_project("key").class.should == Backlog::Object::Project
      end
    end
  end

  describe "カテゴリAPI" do
    context "プロジェクトのカテゴリを取得する" do
      let(:component) {
        [{"id" => 100,
          "name" => "カテゴリ名"}]
      }

      before do
        @client = Backlog::Client.new("hoge", "yoppi", "test")
        mock(@client).call.with_any_args { component }
      end

      it "指定したプロジェクトのカテゴリが取得できる" do
        @client.get_components(100).class.should == Array
      end

      it "取得したカテゴリはすべてカテゴリオブジェクトである" do
        @client.get_components(100).each {|component|
          component.class.should == Backlog::Object::Component
        }
      end
    end
  end
end
