require 'spec_helper'

describe Constantinopolis::Fort do

  class NoYaml < Constantinopolis::Fort
  end

  class WithYaml < Constantinopolis::Fort
    yml File.expand_path('../setting.yml', __FILE__)
  end
  WithYaml.build!

  class WithNamespace < Constantinopolis::Fort
    yml File.expand_path('../setting_with_namespace.yml', __FILE__)
    namespace :test
  end
  WithNamespace.build!

  describe "::build!" do
    context "when not located yaml file" do
      it "raises error" do
        expect { NoYaml.build! }.to raise_error(RuntimeError, "Must locate yaml file!")
      end
    end
  end

  describe "any keys" do
    context "when located yaml file" do
      it { expect(WithYaml.hello).to eq "Hello, CONSTANTINOPOLIS!" }
      it { expect(WithYaml.number).to eq 10 }
      it { expect(WithYaml.go.to.hospital).to eq "Go to hospital." }
    end

    context "when indicated namaespace" do
      it { expect(WithNamespace.common).to eq "Common value" }
      it { expect(WithNamespace.hello).to eq "Hello, test!" }
    end
  end

  describe "::js_code" do
    subject(:js_code) { WithYaml.js_code }
    it { expect(js_code).to match /WithYaml={.*};/m }
    it { expect(js_code).to match /"hello":"Hello, CONSTANTINOPOLIS!"/m }
    it { expect(js_code).to match /"number":10/m }
    it { expect(js_code).to match /"go":{"to":{"hospital":"Go to hospital."}}/m }
  end
end