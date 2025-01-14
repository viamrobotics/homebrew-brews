class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.58.0.tar.gz"
  sha256 "23f1813e238f562a87e25f82f95142bdfd6382591d6297666f82794d90a71c97"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 14
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2cc09b897d9f6c3c750617fa737527bf325a13d522a1bb16382781f4cc638806"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "17b052c3d91e87dae0bfe6b99e96d07590f140fab4507971b7cdf30a1e9938a2"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a30065094512311114af00b5a13d6d1d0df1300cd9a9c26be4ffdee34e68b904"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
