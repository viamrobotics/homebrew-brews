class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.65.0.tar.gz"
  sha256 "5bd16a5e594856b6a3b7b26cae888ff27b19170d28bf7a5ba14e356f75378a7a"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 23
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c5dbc4b0d0a6199286354ca1fd249c858a79e8f5854d6ce6307c6d86c3b1dcf0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "50a9725674b004b60cdc882f8c1dd35fbe5fbd37160b32e0c25bdc805f5f6c74"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4146a045bffbca1ecda8b0d9c489f8963331962cf0fd9a4c38f99c9f2d5d4b93"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
