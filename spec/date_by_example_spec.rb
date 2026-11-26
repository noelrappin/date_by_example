RSpec.describe DateByExample do
  it "has a version number" do
    expect(DateByExample::VERSION).not_to be_nil
  end

  it "eager loads every file under Zeitwerk" do
    expect { Zeitwerk::Loader.eager_load_all }.not_to raise_error
  end

  it "loads with a plain require, outside bundler and the gemspec" do
    script = 'require "date_by_example"; exit(Date.today.respond_to?(:by_example) ? 0 : 1)'
    zeitwerk = Gem.loaded_specs["zeitwerk"].full_require_paths.first
    loaded = Bundler.with_unbundled_env do
      system(RbConfig.ruby, "-Ilib", "-I#{zeitwerk}", "-e", script, exception: false)
    end
    expect(loaded).to be(true)
  end

  it "keeps the top-level ExampleFormatter name from 0.1" do
    expect(ExampleFormatter).to eq(DateByExample::ExampleFormatter)
  end

  it "adds by_example to Date, DateTime, and Time" do
    expect([Date.today, DateTime.now, Time.now]).to all(respond_to(:by_example))
  end
end
