class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.101.0.tar.gz"
  sha256 "4686fe9c2849fd3cce6c8289b3cce4c862877390ea95dceb93909f40eca3ae55"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 40
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d5b11631cebf6f7be7f61a5bb378f8a42edf1c9a0653df48e8ec689c6801c098"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2771ebf6b5e71c7c0dbfc28a0022331b9f0873e8341c40d7105ab1245a7be748"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ac9da69bd1eae29126f8e28a1d80fd45a3efa730a3812c9fdd50ffd1e584e5ca"
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
