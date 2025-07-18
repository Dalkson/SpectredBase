async function getNetworkInfo() {
    try {
        const blockrewardResponse = await fetch('https://api.spectre-network.org/info/blockreward?stringOnly=false', {
            headers: { 'accept': 'application/json' }
        });
        const blockrewardData = await blockrewardResponse.json();
        const blockreward = blockrewardData.blockreward;

        const hashrateResponse = await fetch('https://api.spectre-network.org/info/hashrate?stringOnly=false', {
            headers: { 'accept': 'application/json' }
        });
        const hashrateData = await hashrateResponse.json();
        const networkHashrate = hashrateData.hashrate; // in TH/s

        return { blockreward, networkHashrate };
    } catch (error) {
        console.error(`An error occurred while fetching network info: ${error}`);
        return { blockreward: null, networkHashrate: null };
    }
}

function rewardsInRange(blockreward, blocks) {
    return blockreward * blocks;
}

function getMiningRewards(blockreward, percentOfNetwork) {
    const rewards = {};
    rewards['hour'] = rewardsInRange(blockreward, 60 * 60) * percentOfNetwork;
    rewards['day'] = rewardsInRange(blockreward, 60 * 60 * 24) * percentOfNetwork;
    rewards['week'] = rewardsInRange(blockreward, 60 * 60 * 24 * 7) * percentOfNetwork;
    rewards['month'] = rewardsInRange(blockreward, 60 * 60 * 24 * (365.25 / 12)) * percentOfNetwork;
    rewards['year'] = rewardsInRange(blockreward, 60 * 60 * 24 * 365.25) * percentOfNetwork;
    return rewards;
}

async function getMarketInfo() {
    try {
        const nonkycResponse = await fetch('https://api.nonkyc.io/api/v2/ticker/spr%2Fusdt', {
            headers: { 'accept': 'application/json' }
        });
        const nonkycData = await nonkycResponse.json();
        const price = nonkycData.last_price;
        return price;
    } catch (error) {
        console.error(`An error occurred while fetching market info: ${error}`);
        return { price: null };
    }
}

async function calculateRewards() {
    const { blockreward, networkHashrate } = await getNetworkInfo();
    const price = await getMarketInfo();
    if (blockreward !== null && networkHashrate !== null && price !== null) {
        const ownHashrateKhs = parseFloat(document.getElementById("hashrateInput").value);

        const ownHashrateThs = ownHashrateKhs / 1_000_000_000; // Convert kH/s to TH/s
        const percentOfNetwork = ownHashrateThs / parseFloat(networkHashrate);
        const networkHashrateMhs = parseFloat(networkHashrate) * 1_000_000; // Convert TH/s to MH/s

        const rewards = getMiningRewards(blockreward, percentOfNetwork);

        document.getElementById("dailySPR").innerText = `${rewards['day'].toFixed(6)} SPR`;
        document.getElementById("dailyUsd").innerText = `${(rewards['day'] * price).toFixed(3)} USD`; // Example conversion rate

        document.getElementById("weeklySPR").innerText = `${rewards['week'].toFixed(6)} SPR`;
        document.getElementById("weeklyUsd").innerText = `${(rewards['week'] * price).toFixed(3)} USD`; // Example conversion rate

        document.getElementById("monthlySPR").innerText = `${rewards['month'].toFixed(6)} SPR`;
        document.getElementById("monthlyUsd").innerText = `${(rewards['month'] * price).toFixed(3)} USD`; // Example conversion rate
    }
}

// Initial calculation on page load

calculateRewards();
