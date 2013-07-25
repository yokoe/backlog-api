# coding: utf-8

module Backlog
  module API
    class ArgumentError < StandardError ; end

    def get_projects
      self.call("backlog.getProjects").map {|project|
        Backlog::Object::Project.new(project)
      }
    end

    # String | Integer -> Backlog::Object::Project
    def get_project(project_key)
      Backlog::Object::Project.new(
        self.call("backlog.getProject", conv_str_to_int(project_key))
      )
    end

    def get_components(project_id)
      self.call("backlog.getComponents", project_id).map {|component|
        Backlog::Object::Component.new(component)
      }
    end

    def get_versions(project_id)
      self.call("backlog.getVersions", project_id).map {|version|
        Backlog::Object::Version.new(version)
      }
    end

    def get_users(project_id)
      self.call("backlog.getUsers", project_id).map {|user|
        Backlog::Object::User.new(user)
      }
    end

    # String | Integer -> Backlog::Object::DetailUser
    def get_user(user_key)
      Backlog::Object::DetailUser.new(
        self.call("backlog.getUser", conv_str_to_int(user_key))
      )
    end

    # String | Integer -> Backlog::Object::UserIcon
    def get_user_icon(user_key)
      Backlog::Object::UserIcon.new(
        self.call("backlog.getUserIcon", conv_str_to_int(user_key))
      )
    end

    def get_issue_types(project_id)
      self.call("backlog.getIssueTypes", project_id).map {|issue_type|
        Backlog::Object::IssueType.new(issue_type)
      }
    end

    # String | Integer -> Backlog::Object::Issue
    def get_issue(issue_key)
      Backlog::Object::Issue.new(
        self.call("backlog.getIssue", conv_str_to_int(issue_key))
      )
    end

    def get_comments(issue_id)
      self.call("backlog.getComments", issue_id).map {|comment|
        Backlog::Object::Comment.new(comment)
      }
    end

    def get_timeline
      self.call("backlog.getTimeline").map {|timeline|
        Backlog::Object::Timeline.new(timeline)
      }
    end

    def get_activity_types
      self.call("backlog.getActivityTypes").map {|activity_type|
        Backlog::Object::ActivityType.new(activity_type)
      }
    end

    def get_statuses
      self.call("backlog.getStatuses").map {|status|
        Backlog::Object::Status.new(status)
      }
    end

    def get_resolutions
      self.call("backlog.getResolutions").map {|resolution|
        Backlog::Object::Resolution.new(resolution)
      }
    end

    def get_priorities
      self.call("backlog.getPriorities").map {|priority|
        Backlog::Object::Priority.new(priority)
      }
    end

    # Integer -> (String|Integer) -> Backlog::Object::CustomFields
    def get_custom_fields(project_id, issue_type=nil)
      h = {"project_id" => project_id}
      if issue_type.instance_of? String
        h["issue_type"] = issue_type
      elsif issue_type.instance_of? Integer
        h["issue_type_id"] = isuissue_type
      end
      self.call("backlog.getCustomFields", h).map {|custom_field|
        Backlog::Object::CustomField.new(custom_field)
      }
    end

    # Hash -> Integer
    def count_issue(condition)
      raise Backlog::API::ArgumentError, "must specify 'projectId'" unless condition.has_key? "projectId"
      condition = Backlog::Object::FindCondition.new(condition)
      self.call("backlog.countIssue", condition.to_h)
    end

    def create_issue(params)
      Backlog::Object::Issue.new(
        self.call("backlog.createIssue", params)
      )
    end

    def switch_issue_status(issue_key, status_id)
      self.call("backlog.switchStatus", {"key" => issue_key, "statusId" => status_id})
    end

    def add_comment(issue_key, content)
      p content
      self.call("backlog.addComment", {"key" => issue_key, "content" => content})
    end

    # String(Integer) -> Integer
    # String(String) -> String
    # Integer -> Integer
    def conv_str_to_int(x)
      if x.instance_of? String
        (x.to_i.zero? && x != "0") ? x : x.to_i
      else
        x
      end
    end
  end
end
