# WARNING: Please note that if you add or change the formats name
# or if you add or remove assets, you'll have to update the JS

namespace :bake do


  desc "Bake Planets"
  task :planets do
    Batch.each(Dir['app/assets/images/planets/raw/**/*.png']) do |file|
      file = "#{Rails.root}/#{file}"
      new_filename = file.gsub("/raw/", "/baked/")
      `convert -quality 90 "#{file}" "#{new_filename}"`
    end
  end
  # task :old_planets do
  #   Batch.each(Dir['app/assets/images/planets/raw/**/*.png'] + Dir['app/assets/images/planets/raw/**/*.png']) do |file|
  #     file = "#{Rails.root}/#{file}"
  #     new_filename = file.gsub("/raw/", "/baked/")

  #     if file.include?(".jpg")
  #       new_filename = new_filename.gsub(".jpg", ".png")
  #       `convert -quality 90 "#{file}" "#{new_filename}"`
  #     else
  #       `cp "#{file}" "#{new_filename}"`
  #     end

  #     n = File.basename(new_filename).match(/(\d)+/)[0].to_i
  #     tmp_file = new_filename
  #     [
  #       {geometry: "x100", name: "tiny"},
  #       {geometry: "x200", name: "small"},
  #       {geometry: "x300", name: "medium"},
  #       {geometry: "x400", name: "big"},
  #       {geometry: "x800", name: "giant"},
  #     ].each do |format|
  #       begin
  #         new_filename = "#{File.dirname(new_filename)}/#{format[:name]}_#{n}.png"
  #         # puts "*****"
  #         # puts tmp_file
  #         # puts new_filename
  #         # puts "*****"
  #         `convert -resize "#{format[:geometry]}" -quality 90 "#{tmp_file}" "#{new_filename}"`
  #       rescue
  #         puts "can't process file: #{file}"
  #       end
  #     end
  #     `rm "#{tmp_file}"`
  #   end
  # end

  desc "Bake Backgrounds"
  task :backgrounds do
    Batch.each(Dir['app/assets/images/backgrounds/raw/**/*.jpg']) do |file|
      file = "#{Rails.root}/#{file}"
      new_filename = file.gsub("/raw/", "/baked/")

      # `convert -quality 90 "#{file}" "#{new_filename}"`
      # `pngcrush -reduce -brute "#{new_filename}" "#{new_filename}.crushing"`
      # `mv "#{new_filename}.crushing" "#{new_filename}"`
      `jpegtran -copy none -optimize -perfect -outfile "#{new_filename}.crushing" "#{file}"`
      `mv "#{new_filename}.crushing" "#{new_filename}"`
    end
  end


  desc "Bake Ships"
  task :ships do
    Batch.each(Dir['app/assets/images/ships/raw/**/*.png']) do |file|
      new_filename = file.gsub("/raw/", "/baked/")
      Dir.mkdir("#{Rails.root}/#{File.dirname(new_filename)}") unless Dir.exist?(File.dirname(new_filename))

      [
        {geometry: "x76", name: "start_screen"},
      ].each do |format|
        begin
          n = File.basename(new_filename).match(/(\d)+/)[0].to_i
          new_filename = "#{Rails.root}/#{File.dirname(new_filename)}/#{format[:name]}_#{n}.png"
          file = "#{Rails.root}/#{file}"

          `convert -resize "#{format[:geometry]}" -quality 90 "#{file}" "#{new_filename}"`
          # `pngcrush -rem alla -reduce -brute "#{new_filename}" "#{new_filename}".crushing`
          # `mv #{new_filename}.crushing #{new_filename}`
        rescue
          puts "can't process file: #{file}"
        end
      end
    end
  end

end