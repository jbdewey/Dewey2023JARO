%% Plot Fig 5A-H from Dewey and Shera (2023) JARO
close all;clear;clc;
load Dewey_2023_JARO_figs.mat

panels = [{'a'};{'b'};{'c'};{'d'};{'e'};{'f'};{'g'};{'h'}]; % panel letters
panelN = length(panels);

f2f1ratios = [1.095 1.295]; % f2/f1 ratios to plot
f2f1ratioN = length(f2f1ratios);

locs = [{'BM'};{'OHC'};{'TM'};{'EC'}]; % measurement locations   
locN = length(locs);
clrs = [{[28 82 172]/255}; {[237 118 194]/255}; {[255 148 0]/255}; {'r'}]; % plot colors

components = [{'f2'};{'f1'};{'dp2f1_m1f2'};{'dp2f2_m1f1'};{'dp1f2_m1f1'}]; % components to highlight
componentN = length(components);
component_clrs = [{'k'};{[.7 .7 .7]};  {'r'}; {[130 76 251]/255}; {[1 188 251]/255}]; % component colors

% Plot
xlims = [0 27.5]; % x-limits
mrklw = 2; % line width for component markers
mrksz = 5; % marker size
 
% Set up figure for each f2/f1 ratio
for r_i = 1:f2f1ratioN
    h=figure('units','normalized','position', [.15 .15 .64 .25]);
    if r_i==1
        pltH = .7824; % plot height
    else
        pltH = .7;
    end

    % Plot each row of panels
    for loc_i = 1:locN
        loc = locs{loc_i};
        clr = clrs{loc_i};
        p_i = (r_i-1)*locN + loc_i;
        panel = panels{p_i};

        if strcmp(loc,'EC') %% Ear canal spectrum

            f = fig5.(genvarname(panel)).(genvarname(loc)).mic.spec_f; % frequency (Hz)
            mag =  fig5.(genvarname(panel)).(genvarname(loc)).mic.spec_mag; % magnitude (Pa RMS)
            f1 = fig5.(genvarname(panel)).(genvarname(loc)).f1; % f1 (Hz)
            f2 = fig5.(genvarname(panel)).(genvarname(loc)).f2; % f2 (Hz)

            % Set up figure
            axs(loc_i).ax = axes('position',[.77 .15 .2 pltH], 'box','off','LineWidth', 1.4, 'FontSize', 15, 'Visible','off'); hold on;
            xlim(xlims);       
            if r_i==1
                ylim([-20 75]);
            else
                ylim([-20 65]); 
            end

            % Plot spectrum
            axes(axs(loc_i).ax);
            plot(f/1000, 20*log10(mag/2e-5), 'LineWidth', 1.1, 'Color', clr);

            % Plot component magnitudes
            for c_i = 1:componentN
                c_x = components{c_i}; % component
                c_clr = component_clrs{c_i}; % color
                switch c_x
                    case 'f1'
                        fx = f1;
                    case 'f2'
                        fx = f2;
                    case 'dp2f1_m1f2'
                        fx = 2*f1-f2;
                    case 'dp2f2_m1f1'
                        fx = 2*f2-f1;
                    case 'dp1f2_m1f1'
                        fx = f2-f1;
                end
                
                [~,fx_i]  =  ismember(fx, f);
                mrkclr = 'w';
                plot(f(fx_i)/1000, 20*log10(mag(fx_i)/2e-5), 'o', 'Color', c_clr, 'LineWidth', mrklw, 'MarkerSize', mrksz,'MarkerFaceColor',mrkclr);      
            end

            % Axis visibility
            pos = get(gca,'position');
            axs(loc_i).axb = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none'); hold on;
            xlim(xlims);       
            
            if r_i==1
                ylim([-20 75]);
                set(gca,'XtickLabels',' ');
            else
                ylim([-20 65]); 
            end
            set(gca,'Ytick',-60:20:100);
        
            axs(loc_i).axb.XAxis.MinorTick = 'on';
            axs(loc_i).axb.XAxis.MinorTickValues = 0:5:30;
            axs(loc_i).axb.XAxis.TickDirection = 'out';
            axs(loc_i).axb.XAxis.TickLength = [.02 .02];
            axs(loc_i).axb.YAxis.TickLength = [.016 .016];

        else % Vibration spectrum
            
            f = fig5.(genvarname(panel)).(genvarname(loc)).vib.spec_f; % frequency (Hz)
            mag = fig5.(genvarname(panel)).(genvarname(loc)).vib.spec_mag; % magnitude (nm RMS)
            f1 = fig5.(genvarname(panel)).(genvarname(loc)).f1; % f1 (Hz)
            f2 = fig5.(genvarname(panel)).(genvarname(loc)).f2; % f2 (Hz)

            % Set up figure
            axs(loc_i).ax = axes('position',[.04 + (loc_i-1)*(.22) .15 .2 pltH], 'box','off','LineWidth', 1.4, 'FontSize', 15, 'Visible','off'); hold on;
            xlim(xlims);
    
            if r_i==1
                ylim([-55 40]);
            else
                ylim([-55 30]); 
            end

            % Plot spectrum
            axes(axs(loc_i).ax);
            plot(f/1000, 20*log10(mag), 'LineWidth', 1.1, 'Color', clr);

           % Plot component magnitudes
            for c_i = 1:componentN
                c_x = components{c_i}; % component
                c_clr = component_clrs{c_i}; % color

                switch c_x
                    case 'f1'
                        fx = f1;
                    case 'f2'
                        fx = f2;
                    case 'dp2f1_m1f2'
                        fx = 2*f1-f2;
                    case 'dp2f2_m1f1'
                        fx = 2*f2-f1;
                    case 'dp1f2_m1f1'
                        fx = f2-f1;
                end
                
                [~,fx_i]  =  ismember(fx, f);
                mrkclr = 'w';
                plot(f(fx_i)/1000, 20*log10(mag(fx_i)), 'o', 'Color', c_clr, 'LineWidth', mrklw, 'MarkerSize', mrksz,'MarkerFaceColor',mrkclr);      
            end

            % Axis visibility
            pos = get(gca,'position');
            axs(loc_i).axb = axes('position',pos, 'box','off','LineWidth', 1.4, 'FontSize', 15,'Color','none'); hold on;
            xlim(xlims);       
            
            if r_i==1
                ylim([-55 40]);
                set(gca,'XtickLabels',' ');
            else
                ylim([-55 30]); 
            end

            set(gca,'Ytick',-60:20:100);
            set(gca,'Xtick',0:10:30);

            axs(loc_i).axb.XAxis.MinorTick = 'on';
            axs(loc_i).axb.XAxis.MinorTickValues = 0:5:30;
            axs(loc_i).axb.XAxis.TickDirection = 'out';
            axs(loc_i).axb.XAxis.TickLength = [.02 .02];
            axs(loc_i).axb.YAxis.TickLength = [.016 .016];

            if strcmp(loc,'OHC') || strcmp(loc,'TM')
                set(gca,'YtickLabels','');
            end
        end
    end
end
