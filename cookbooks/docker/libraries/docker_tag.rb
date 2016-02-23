module DockerCookbook
<<<<<<< HEAD
  class DockerTag < DockerBase
    resource_name :docker_tag
=======
  class DockerTag < ChefCompat::Resource
    use_automatic_resource_name
>>>>>>> chef-vendor-docker

    property :target_repo, String, name_property: true
    property :target_tag, String
    property :to_repo, String
    property :to_tag, String
<<<<<<< HEAD
    property :force, Boolean, default: false
=======
>>>>>>> chef-vendor-docker

    #########
    # Actions
    #########

    action :tag do
<<<<<<< HEAD
      return if force == false && Docker::Image.exist?("#{to_repo}:#{to_tag}")
      begin
        converge_by "update #{target_repo}:#{target_tag} to #{to_repo}:#{to_tag}" do
          i = Docker::Image.get("#{target_repo}:#{target_tag}")
          i.tag('repo' => to_repo, 'tag' => to_tag, 'force' => force)
=======
      return if Docker::Image.exist?("#{to_repo}:#{to_tag}")
      begin
        converge_by "update #{target_repo}:#{target_tag} to #{to_repo}:#{to_tag}" do
          i = Docker::Image.get("#{target_repo}:#{target_tag}")
          i.tag('repo' => to_repo, 'tag' => to_tag, 'force' => true)
>>>>>>> chef-vendor-docker
        end
      rescue Docker::Error => e
        raise e.message
      end
    end
  end
end
