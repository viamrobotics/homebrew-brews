class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.17.0.tar.gz"
  sha256 "2f50a322866bbf0bef5edd436f7bb2e30332c69d701236f39469a286ffe51d00"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 41
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "482670ccb021bccd987c9db54bc2e462c808d6fe5e3322540056e91377b459a8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e503abe175bf6257020c7cbcc6bebfe6fd0c5b7c9607f65550f4d693a6f4c20"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5e367bd3637b68091c157990df2a52dff6d776d8393abcc2c60a1db16c4c7687"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
