require 'formula'

class VrJuggler <Formula
  head 'https://github.com/casallas/vrjuggler-1.git', :branch => 'mac-cmake-3.0'
  homepage 'http://code.google.com/p/vrjuggler/'
  url 'https://github.com/casallas/vrjuggler-1.git', :branch => 'mac-cmake-3.0'
  version '3.0.0-1'

  depends_on 'cmake' => :build
  depends_on 'boost'
  depends_on 'cppdom'
  depends_on 'casallas/vr/gmtl'
  depends_on 'flagpoll'
  depends_on 'freealut' => :recommended
  depends_on 'vrpn' => :recommended
  depends_on 'omniorb' => :optional

  # There seems to be a problem with unnamed semaphores on Mac OS X
  # e.g. http://sourceforge.net/p/vrjuggler/mailman/message/10866972/
  patch do
    url "https://gist.githubusercontent.com/anonymous/c4d725541a215b2267a1/raw/ae9c2c752a9493acfdbaa0c8caa4df440c9dfecf/vpr_semaphore_patch.diff"
    sha1 "e3089919aa230d536d038d7658a172bb121fb659"
  end

  def install
    args = ["..", "-DCMAKE_INSTALL_PREFIX='#{prefix}'", "-DCMAKE_BUILD_TYPE=None", "-DCMAKE_FIND_FRAMEWORK=LAST", "-Wno-dev", "-DBUILD_JAVA=OFF"]
    Dir.mkdir "build"
    Dir.chdir "build" do
      system "cmake", *args
      system "make install"
    end
  end

  def caveats
    "VRJConfig.app and Tweek.app can't currently be installed using homebrew, due to some troubles with Java in OS X"
  end
end
