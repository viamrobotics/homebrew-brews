class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.94.1.tar.gz"
  sha256 "9e29895cbe5a4589d2bac0156d0adf093f22136bc02232d9c11268a62f671c7f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 29
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1bcd7589e76decc25a1c1f4bd0ee32ae378110f285d8a7c978716b082293b552"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1e7f1145c7ec4ea8a3c26efa48bff2bbaa9cebfa6ed65cfadc93c56550129452"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "92a79a6f8a250f8a02611fc82620051a80da133908594282d06f28576b32c094"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
