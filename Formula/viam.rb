class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.55.1.tar.gz"
  sha256 "b844f362c4e46b6b8f83043080b1069c0630ad24bbe06003b66f7c9d6d7564fa"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 11
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "62236f6446b2e72c70c281c9d51f18e02b5ce0472a0afcc73a329041e4ea1dc8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3c24727973b269142aa376ffb3add86c9eea3ffa132e619e9a83eae93ab7826b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "94b77475508b9896b534ae0d090919e11c47726be2301045a0e5b3000888d9b3"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
