#!/usr/bin/perl

#  Makefile.PL
#
#  Part of:
#  BridgeDealer - hand dealing system
#  Copyright (c) 2000 Michal J. Kubski
#  All rights reserved.

use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile being created.

WriteMakefile(
 'NAME'         => 'BridgeDealer',
 'DISTNAME'     => 'BridgeDealer',
 'VERSION_FROM' => 'version',
 'OBJECT'       => 'BridgeDealer.o dealer.o',
 'CC'           => 'g++',
 'PM'           => {
                    'BridgeDealer.pm'     => '$(INST_LIB)/BridgeDealer.pm',
                    'lib/tableprint.al'   => '$(INST_ARCHLIB)/auto/BridgeDealer/tableprint.al',
                    'lib/genhcp.al'       => '$(INST_ARCHLIB)/auto/BridgeDealer/genhcp.al',
                    'lib/vector.al'       => '$(INST_ARCHLIB)/auto/BridgeDealer/vector.al',
                    'lib/sethand.al'      => '$(INST_ARCHLIB)/auto/BridgeDealer/sethand.al',
                    'lib/simpleprint.al'  => '$(INST_ARCHLIB)/auto/BridgeDealer/simpleprint.al',
                    'lib/BridgeDealer.dh' => '$(INST_LIB)/BridgeDealer/BridgeDealer.dh',
                    'lib/testing.dh'      => '$(INST_LIB)/BridgeDealer/testing.dh',
                    'bin/BridgeDealer'    => '$(INST_BIN)/BridgeDealer'
                   },
 'OPTIMIZE'     => '-O3 -m486',
 'depend'       => {
                    'Makefile' => 'version'
                   },
 'dist'         => {
                    COMPRESS   => 'gzip',
                    SUFFIX     => 'gz'
                   }
);
