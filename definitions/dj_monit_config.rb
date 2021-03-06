define :dj_monit_config do
  params[:name].each do |application_options|
    application_options['background_workers'].times do |i|

      options = {
          user:        node['rails-stack']['deployer'],
          app_name:    application_options[:name],
          rails_env:   application_options[:rails_env],
          app_path:    "#{node['rails-stack']['data_path']}/apps/#{application_options[:name]}/current",
          tmp_path:    "#{node['rails-stack']['data_path']}/apps/#{application_options[:name]}/shared/tmp",
          worker_name: "#{application_options[:name]}_delayed_job_#{i+1}",
          index:       i
      }

      monitrc options[:worker_name] do
        template_source 'dj.monitrc.erb'
        template_cookbook 'delayed_job'
        variables options
      end

    end
  end
end
