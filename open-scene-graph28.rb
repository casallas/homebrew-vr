require 'formula'

class OpenSceneGraph28 < Formula
  url 'https://github.com/casallas/osg/tarball/3743ee6967864a1fcef4a363e52b68356b116ce6'
  sha1 '83d20a151a1ab1ead0e49415ed54e9cccf8c0d24'
  version '2.8.6'
  homepage 'http://www.openscenegraph.org/'

  keg_only "This is an older formula of openscenegraph"

  depends_on 'cmake' => :build
  depends_on 'jpeg'
  depends_on 'wget'
  #depends_on 'ffmpeg' => :optional #osgdb_ffmpeg doesn't build right with new ffmpeg versions
  depends_on 'gdal' => :optional
  depends_on 'jasper' => :optional
  depends_on 'openexr' => :optional
  depends_on 'collada-dom' => :optional
  #depends_on 'dcmtk' => :optional
  depends_on 'librsvg' => :optional

  conflicts_with 'dcmtk',
    :because => "The osgdb_dicom plugin doesn't build right with new dcmtk versions"

  def install
    args = ["..", "-DCMAKE_INSTALL_PREFIX='#{prefix}'", "-DCMAKE_BUILD_TYPE=None", "-Wno-dev", "-DBUILD_OSG_WRAPPERS=ON", "-DBUILD_DOCUMENTATION=ON"]
    if snow_leopard_64?
      args << "-DCMAKE_OSX_ARCHITECTURES=x86_64"
      args << "-DOSG_DEFAULT_IMAGE_PLUGIN_FOR_OSX=imageio"
      args << "-DOSG_WINDOWING_SYSTEM=Cocoa"
    else
      args << "-DCMAKE_OSX_ARCHITECTURES=i386"
    end

    if Formula.factory('collada-dom').installed?
      args << "-DCOLLADA_INCLUDE_DIR=#{HOMEBREW_PREFIX}/include/collada-dom"
    end

    Dir.mkdir "build"
    Dir.chdir "build" do
      system "cmake", *args
      system "make install"
    end
  end

  def patches
    # The mini-Boost finder in FindCOLLADA doesn't find our boost, so fix it.
    return DATA
  end

end

__END__
diff --git a/CMakeModules/FindCOLLADA.cmake b/CMakeModules/FindCOLLADA.cmake
index 5af53fe..d2369ef 100644
--- a/CMakeModules/FindCOLLADA.cmake
+++ b/CMakeModules/FindCOLLADA.cmake
@@ -224,7 +224,7 @@ FIND_LIBRARY(COLLADA_STATIC_LIBRARY_DEBUG
     )

     FIND_LIBRARY(COLLADA_BOOST_FILESYSTEM_LIBRARY
-        NAMES libboost_filesystem boost_filesystem
+        NAMES libboost_filesystem boost_filesystem boost_filesystem-mt
         PATHS
         ${COLLADA_DOM_ROOT}/external-libs/boost/lib/${COLLADA_BUILDNAME}
         ${COLLADA_DOM_ROOT}/external-libs/boost/lib/mingw
@@ -238,7 +238,7 @@ FIND_LIBRARY(COLLADA_STATIC_LIBRARY_DEBUG
     )

     FIND_LIBRARY(COLLADA_BOOST_SYSTEM_LIBRARY
-        NAMES libboost_system boost_system
+        NAMES libboost_system boost_system boost_system-mt
         PATHS
         ${COLLADA_DOM_ROOT}/external-libs/boost/lib/${COLLADA_BUILDNAME}
         ${COLLADA_DOM_ROOT}/external-libs/boost/lib/mingw
