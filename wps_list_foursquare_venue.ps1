$CLIENT_ID="?";
$CLIENT_SECRET="?";

function BuscaLocais([float]$latitude, [float]$longitude, [int]$metros)
{
    $proxy = [System.Net.WebRequest]::GetSystemWebProxy().GetProxy("http://www.google.com")
    $url = "https://api.foursquare.com/v2/venues/search?ll="+$latitude+","+$longitude+"&intent=browse&limit=100&radius="+$metros+"&client_id="+$CLIENT_ID+"&client_secret="+$CLIENT_SECRET+"&v="+(Get-Date).ToString("yyyyMMdd")+"";
    $result = Invoke-RestMethod -Uri $url -Method GET -UseDefaultCredentials -Proxy $proxy -ProxyUseDefaultCredentials
    return $result;
}

$result = BuscaLocais -latitude "-23.56" -longitude "-46.65" -metros 100 

if ($result.meta.code -eq 200)
{
    Write-Host "Lugares encontrados: " + $result.response.venues.Count -ForegroundColor Green
    $result.response.venues | Select id, Name, location, categories, stats, verified | ConvertTo-Json | Out-Host
}

