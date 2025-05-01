class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.73.1.tar.gz"
  sha256 "57c409bbdfa0fa5269f6c4b318c0e8c21a5ebff836a207f0e1f7c23553467e93"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e6730f64415b9bacc012ed11e882e0ffe784f8b7767a487f4ef0b997903a99e7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "48edca395da1e5f5c2bc295283baa714a23d98b3315fd457969163a88b7df688"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "54f4ed8cd2b09ca155bd3a96429f60e409a3956c86941312556a542d623435a0"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
