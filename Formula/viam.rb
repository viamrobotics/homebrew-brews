class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.112.0.tar.gz"
  sha256 "f32563ddac14ed5867c977a53bcc77c2ad980a4ea3ef9cec97bfc41cf912b2b8"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 56
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2ee1ef7a4033f1ec3f1a9ff022768d1da3239f4eaefd93cca5704805a89a3ddb"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b939b8e1d3bbb13919cd06cfaee67869468a9b4243ee99a148131697cf1ea79d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8bf23284cccf6fa8596ab8582965c1c5bbf8086eea11530539e8cb82a9f69e8e"
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
