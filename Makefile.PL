# Makefile for Authen-ACE4
#
# Copyright C 2001 Open System Consultants
# Author: Mike McCauley (mikem@open.com.au)
# $Id: Makefile.PL,v 1.1 2001/07/28 02:40:47 mikem Exp $


# ON Unix, Set your ACE/Agent version number here
#$sd_version = 4;
$sd_version = 5;

# Adjust these paths to suit your system
if ($^O eq 'MSWin32')
{
    # Windows
    $libs = ['-L"C:\Program Files\Microsoft Visual Studio\VC98\Lib" -LC:\Ace\acesupp\nt_clnt\sdk\lib -laceclnt'];
    $inc = '-IC:\Ace\acesupp\nt_clnt\sdk\include',
    $define = '',
}
else
{
    # Unix
    # Something like this for V 4.1
    # Note, on Solaris the ACE agent client libs that are supplied
    # with ACE/Server 4.1 hang in AceCloseAuth. You need	
    # a patched version of the libraries from SecurID.
    if ($sd_version == 4)
    {
	$acedir = '/opt/ace/ace4';
	$libs = ["-L$acedir/examples/multithread -laceclnt -lpthread"];
	$inc = "-I$acedir/examples/multithread -I$acedir/examples";
	$define = '-DUNIX -DSD_VERSION=4',
    }
    else
    {
	# For V 5.0:
	$acedir = '/opt/ace/ACEAgentSDK';
	$libs = ["-L$acedir/lib/sol -laceclnt -lpthread"];
	$inc = "-I$acedir/inc -I$acedir";
	$define = '-DUNIX -DSD_VERSION=5',
    }
}

use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	=> 'Authen::ACE4',
    'VERSION_FROM' => 'ACE4.pm',
    'LIBS'	=> $libs,
    'DEFINE'	=> $define,
    'INC'	=> $inc,
);
