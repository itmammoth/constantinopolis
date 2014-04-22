require 'spec_helper'
require 'constantinopolis'

describe Constantinopolis::Fort do

  class NoYaml < Constantinopolis::Fort
  end

  class WithYaml < Constantinopolis::Fort
    yml "spec/setting.yml"
  end
  WithYaml.build!

  class WithNamespace < Constantinopolis::Fort
    yml "spec/setting_with_namespace.yml"
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
end