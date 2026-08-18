#!/usr/bin/env bash

POLICY=sslo_dlp-traffic-policy-inbound-app

policyexists=true && [[ "$(tmsh list ltm policy ${POLICY} 2>&1)" =~ "was not found" ]] && policyexists=false

if [[ "$policyexists" == "false" ]]; then
    echo "Policy doesn't exist...creating"
    tmsh create ltm policy ${POLICY} legacy strategy first-match controls replace-all-with { data-loss-prevention } requires replace-all-with { http } rules replace-all-with { dlp-fence-ai-inference-http-response { actions replace-all-with { 0 { data-loss-prevention response disable } } conditions replace-all-with { 0 { http-header response name Content-Type values { image/jpeg image/gif image/png image/tiff image/vnd.microsoft.icon image/x-icon image/vnd.djvu image/svg+xml audio/mpeg audio/3gpp2 audio/opus audio/aac audio/mp4 audio/aacp audio/adpcm audio/aiff audio/flac audio/midi audio/basic audio/x-ms-wma audio/vnd.rn-realaudio audio/x-wav audio/vnd.wav audio/webm text/css text/javascript video/mpeg video/mp4 video/quicktime video/x-ms-wmv video/x-msvideo video/x-flv video/webm image/bmp image/avif image/apng image/heic image/heif image/webp application/ogg font/otf font/woff font/woff2 } } } } }
else
    echo "Policy exists...updating"
    tmsh modify ltm policy ${POLICY} legacy strategy first-match controls replace-all-with { data-loss-prevention } requires replace-all-with { http } rules replace-all-with { dlp-fence-ai-inference-http-response { actions replace-all-with { 0 { data-loss-prevention response disable } } conditions replace-all-with { 0 { http-header response name Content-Type values { image/jpeg image/gif image/png image/tiff image/vnd.microsoft.icon image/x-icon image/vnd.djvu image/svg+xml audio/mpeg audio/3gpp2 audio/opus audio/aac audio/mp4 audio/aacp audio/adpcm audio/aiff audio/flac audio/midi audio/basic audio/x-ms-wma audio/vnd.rn-realaudio audio/x-wav audio/vnd.wav audio/webm text/css text/javascript video/mpeg video/mp4 video/quicktime video/x-ms-wmv video/x-msvideo video/x-flv video/webm image/bmp image/avif image/apng image/heic image/heif image/webp application/ogg font/otf font/woff font/woff2 } } } } }
fi
