class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.64.0.tar.gz"
  sha256 "7ed798980c3142af7f3be2ec389ff317ee66335f44c87fc1f9154a79f0decf93"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 21
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "dac9970c117271ae98d5a648c9bd477a0cdf453ecebdab71d159d4dc225c997e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c152ca59785cb87d90a44ac77cf60a7c002242f9d24380407983bbaf34e6ff79"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b7d89f3882898c316ec88b0c58222513e31b60ec093257d72d90f079676f7479"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
