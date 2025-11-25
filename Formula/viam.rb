class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.103.0.tar.gz"
  sha256 "b0f7f92af19724917600c06db1a3f58b72022a9d1dc37a8b64aacebdf1448141"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 43
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9707388deed978aeaad22931ea8dfb96b78636c978879c6df233c5a41f56e688"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "89f0dd9cbc7bfcb6fb4ca1842002b1ea90774f638deaf3bd754dd84f5f4b99dd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cbc69891c50e5786432913d719322feda14ca79f287869860e8d1046430b65bd"
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
