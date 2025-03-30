require 'gherkin'

class ScenarioExtractor
  def self.extract_scenarios(file_path)
    # Ensure file path is absolute
    file_path = File.expand_path(file_path)

    # Check if file exists
    unless File.exist?(file_path)
      puts "Error: Feature file not found at #{file_path}"
      return []
    end

    # Read the feature file
    feature_content = File.read(file_path)

    # Extract scenarios
    scenarios = []

    begin
      # Parse the feature file
      parser = Gherkin::Parser.new
      gherkin_document = parser.parse(feature_content)

      # Check if feature exists
      if gherkin_document&.feature
        feature_name = gherkin_document.feature.name || "Unnamed Feature"

        # Extract feature-level tags
        feature_tags = gherkin_document.feature.tags.map(&:name)

        # Extract scenarios
        gherkin_document.feature.children.each do |child|
          if child.scenario
            # Combine feature tags with scenario tags
            scenario_tags = child.scenario.tags.map(&:name)
            all_tags = feature_tags + scenario_tags

            scenarios << {
              feature: feature_name,
              type: child.scenario.keyword == 'Scenario Outline' ? 'Scenario Outline' : 'Scenario',
              name: child.scenario.name,
              line: child.scenario.location.line,
              tags: all_tags.uniq.join(', ')
            }
          end
        end
      end
    rescue StandardError => e
      puts "Error parsing feature file: #{e.message}"
      puts e.backtrace
      return []
    end

    scenarios
  end

  def self.print_scenarios(scenarios)
    if scenarios.empty?
      puts "No scenarios found."
      return
    end

    puts "Extracted Scenarios:"
    scenarios.each do |scenario|
      puts "Feature: #{scenario[:feature]}"
      puts "#{scenario[:type]} (Line #{scenario[:line]}): #{scenario[:name]}"

      # Print tags if not empty
      if !scenario[:tags].nil? && !scenario[:tags].empty?
        puts "Tags: #{scenario[:tags]}"
      end

      puts "---"
    end

    puts "\nTotal Scenarios: #{scenarios.count}"
  end
end

# Determine script location and project root
script_dir = File.dirname(File.expand_path(__FILE__))
project_root = File.expand_path(File.join(script_dir, "..", '..'))

# Check if feature file path is provided
if ARGV.empty?
  puts "Usage: ruby scenarios_extractor.rb <relative_feature_file_path>"
  puts "Example: ruby scenario_extractor.rb features/authentication.feature"
  exit 1
end

# Construct full path to the feature file
relative_feature_path = ARGV[0]
feature_file_path = File.join(project_root, relative_feature_path)

# Extract scenarios
all_scenarios = ScenarioExtractor.extract_scenarios(feature_file_path)

# Print scenarios
ScenarioExtractor.print_scenarios(all_scenarios)
