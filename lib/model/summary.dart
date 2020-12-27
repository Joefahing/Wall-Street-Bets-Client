class PostSummary {
  final int gain;
  final int loss;
  final double gainGrowthRate;
  final double lossGrowthRate;
  final double volatility;

  PostSummary(
      {this.gain,
      this.loss,
      this.gainGrowthRate,
      this.lossGrowthRate,
      this.volatility});

  factory PostSummary.fromJson({Map<String, dynamic> json}) {
    final currentSummary = json['current_gain_loss_summary'];
    final totalGain = currentSummary['gain_total'];
    final totalLoss = currentSummary['loss_total'];
    final volatility = json['volatility'];
    final gainGrowthRate = json['gain_post_growth_rate'];
    final lossGrowthRate = json['loss_post_growth_rate'];

    return PostSummary(
        gain: totalGain,
        loss: totalLoss,
        volatility: volatility,
        gainGrowthRate: gainGrowthRate,
        lossGrowthRate: lossGrowthRate);
  }
}
