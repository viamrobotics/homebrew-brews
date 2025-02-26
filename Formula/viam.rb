class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.64.0.tar.gz"
  sha256 "7ed798980c3142af7f3be2ec389ff317ee66335f44c87fc1f9154a79f0decf93"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 22
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5df66c83da3718b50e0523fba41a7e68f1e6f5e3cc4cf13052f83de13c9f2cee"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2447ef2b9d1544da302482748cd5fba8eb095d4f334b9373fa0777a8b7e0feab"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "576eba697e3f87e703685710fa249e6bf5dcbcfe6635ee5a905a0dfacdda561f"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
