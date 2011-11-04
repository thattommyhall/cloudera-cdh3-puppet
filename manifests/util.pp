define line(
	$file,
	$line,
	$ensure = 'present'
) {
	case $ensure {
		default : { err ( "unknown ensure value '${ensure}'" ) }
		present: {
			exec { "/bin/echo '${line}' >> '${file}'":
				unless => "/bin/grep -qFx '${line}' '${file}'"
			}
		}
		absent: {
			exec { "/usr/bin/perl -ni -e 'print if \$_ ne \"${line}\n\";' '${file}'":
				onlyif => "/bin/grep -qFx '${line}' '${file}'"
			}
		}
	}
}