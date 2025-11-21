class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.102.1.tar.gz"
  sha256 "dca9e91ac189deff2b1b52a1dbcb9b91d6dfecbb60f3eaa7fc37c84f0f22347a"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 42
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1058c043d0207cc29a5d937f565290127e1fa9d72245deeef8bab6541a5f8d55"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "59d82851edc0f8f8ffc22fa21382699b06a0803e1ea809cdcfde8d1c4363f714"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0564821111f55366fee33a799397906f2112b94095cde760354415f36e1fb60f"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
