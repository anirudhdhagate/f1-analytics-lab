-- Base Metrics layer for Constructors

-- create table `project-1-music-489315.Formula_1.constructor_metrics` as

with results_master as (

  select * from `project-1-music-489315.Formula_1.results_master`
),

--Constructor Metrics to Compute

constructor_totals as (
  select constructor_name,
  count(raceId) as total_races, 
  sum(points) as total_points, 
  sum(case when position = 1 then 1 else 0 end) as total_wins, 
  sum(case when position <= 3 then 1 else 0 end) as total_podiums, 
  sum(case when race_status = 'is_dnf' then 1 else 0 end) as total_dnfs
  from results_master
  group by constructor_name
),

constructor_stats as (
  select *,
  round(total_points / total_races, 2) as points_per_race, 
  round(total_wins / total_races, 2) as win_rate, 
  round(total_podiums / total_races, 2) as podium_rate, 
  round(total_dnfs / total_races, 2) as dnf_rate 
  from constructor_totals
  where total_races >= 50
  order by total_wins desc

)

  select * from constructor_stats;